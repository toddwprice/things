$fn=64;

width = 44.4;
height = 20;
solid_width = 38;
solid_height = 14;
mesh_gap = 2.0;
mesh_width = 0.4;
mesh_height = 0.6;
mesh_length = width;
text_height = 0.8;
font_family = "Blessed Day:style=Regular";

module mesh(thickness) {
  for (i = [0:mesh_gap:mesh_length]) {
    translate([i,0,0])
    cube([mesh_width, height, thickness]);
  }

  for (i = [0:mesh_gap:height]) {
    translate([0,i,0])
    cube([mesh_length, mesh_width, thickness]);
  }
}

color("brown") {
  mesh(mesh_height);

  // solid inner middle
  translate([(width - solid_width) / 2, (height - solid_height + mesh_width)/2, 0])
  cube([solid_width, solid_height, mesh_height]);
}


color("gold") {
  translate([0,0,mesh_height])
  difference() {
    mesh(text_height);

    translate([0,0,-.5])
    linear_extrude(height=text_height+1)
    translate([mesh_width, mesh_height - .2])
    square([width - mesh_width*2, height - mesh_height + .2]);
  }

  translate([6.8,2.5,0])
  linear_extrude(height=mesh_height + text_height) 
  text("Lahey", font=font_family, size=16);
}
