module cube_round(x, y, z, r) {
  translate([r,r,r])
  minkowski() {
    cube([x-r*2,y-r*2, (z - r*2 > 0) ? z - r*2 : .01]);
    sphere(r=r, $fn=80);
  }
}

module button(button_thickness=button_thickness) {
  r = 0.35;

  rotate(90, [0,0,1]) 
  rotate(90, [1,0,0]) 
  linear_extrude(height=button_thickness)
  rounded_rectangle(button_width, button_height, r);
}

module corner_cutter(radius) {
  translate([radius, radius, 0])
  difference() {
    translate([-radius/2, -radius/2, 0]) square([radius, radius], center=true);
    difference() {
      circle(r=radius);
      translate([0, radius/2, 0]) square([radius*2, radius], center=true);
      translate([radius/2, 0, 0]) square([radius, radius*2], center=true);
    }
  }
}


module rounded_rectangle(width,height,corner_radius) {
  difference() {
    square(size=[width, height]);
    // SW
    corner_cutter(corner_radius);
    // SE
    translate([width, 0, 0]) rotate(180, [0,1,0]) corner_cutter(corner_radius);
    // NW
    translate([0, height, 0]) rotate(180, [1,0,0]) corner_cutter(corner_radius);
    // NE
    translate([width, height, 0]) rotate(180, [1,0,0]) rotate(180, [0,1,0]) corner_cutter(corner_radius);
  }
}

module case() {
  difference() {
    // outside shell
    translate([corner_radius, corner_radius, corner_radius])
    minkowski() {
      cube([case_width - corner_radius*2, case_height - corner_radius*2, .01]);
      sphere(r=corner_radius, $fn=80);
    }

    // inner shell space
    x_scale = (case_width - case_wall_thickness*2)/case_width;
    y_scale = (case_height - case_wall_thickness*2)/case_height;
    z_scale = (case_thickness - case_wall_thickness*2)/case_thickness;

    translate([case_wall_thickness, case_wall_thickness, case_wall_thickness/2])
    scale([x_scale, y_scale, z_scale])
    translate([corner_radius, corner_radius, corner_radius])
    minkowski() {
      cube([case_width - corner_radius*2, case_height - corner_radius*2, .01]);
      sphere(r=corner_radius, $fn=80);
    }

    // top window opening
    translate([(case_width - glass_width) / 2, (case_height - glass_height) / 2, case_wall_thickness + 1])
    linear_extrude(height=case_thickness*2)
    rounded_rectangle(glass_width, glass_height, 3);
    // cube([glass_width, glass_height, case_thickness*2]);
  }
}

module cutout(width, height, thickness) {
  linear_extrude(height=thickness)
  union() {
    translate([height/2,height/2,0]) circle(r=height/2);
    translate([height/2, 0, 0]) square([width - height, height], center=false);
    translate([width - height/2,height/2,0]) circle(r=height/2);
  }
}

module edge_shaver(radius,height,thickness) {
  difference() {
    cylinder(r=radius);
    cylinder(r=radius-thickness);
  }
}