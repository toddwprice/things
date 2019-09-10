$fn = 100;
floor_diameter = 94 + (2*17);
height = 24;
wall_angle = 75;
wall_thickness = 1.2;
bump_count = 7;
bump_diameter = 25;
bump_height = 2.5;
floor_text = "L";
floor_font = "Leafs";  // "Leafs" | "Glyphter:bold"
floor_font_size = 34;
floor_offset_x = 0;
floor_offset_y = 0;
wall_text = "";
wall_font = "Leafs";  // "Leafs" | "Glyphter:bold"
wall_font_size = 34;

x = height / tan(wall_angle);
inner_diameter = floor_diameter - (2 * x);

// bumps to raise plant
module bumps() {
  // cylinder(h=wall_thickness + bump_height, r=bump_diameter);
  translate([floor_offset_x,floor_offset_y,0])
  linear_extrude(height=(wall_thickness + bump_height)*0.65)
  offset(r=.2)
  if (floor_text != "") text(floor_text, font=floor_font, size=floor_font_size, halign="center", valign="center");

  
  for(i=[1:bump_count-1])
    bump(i*360/(bump_count-1));
}

module bump(degrees) {
  rotate(degrees, [0,0,1])
  translate([0, (floor_diameter - wall_thickness) / 3, 0])
  cylinder(h=wall_thickness + bump_height, r=bump_diameter/2);
}

module outer_cone() {
  cylinder(h=height, d1=inner_diameter, d2=floor_diameter);
}

module inner_cone() {
  translate([0,0,wall_thickness])
  cylinder(h=height, d1=inner_diameter - wall_thickness, d2=floor_diameter - wall_thickness);
}

module revolve_text(radius, chars) {
  PI = 3.141592654;
  circumference = 2 * PI * radius;
  chars_len = len(chars);
  degrees_per_char = 360/5;
  step_angle = 360 / chars_len;
  for(i = [0 : chars_len - 1]) {
    rotate(i * degrees_per_char) 
    translate([0, radius - wall_thickness*.45, height*.1])
    rotate(180, [0,0,1])
    rotate(11, [0,0,1])
    rotate(180 - wall_angle, [1,0,0])
    linear_extrude(height=wall_thickness*2)
    text(
      chars[i], 
      font = wall_font, 
      size = wall_font_size
    );
  }
}


difference() {
  union() {
    difference() {
      union() {
        outer_cone();
        if (wall_text != "") revolve_text(inner_diameter/2, wall_text);
      }

      inner_cone();
    }

    bumps();
  }


  translate([0,0,-height-.01]) cylinder(d=floor_diameter, h=height);
}