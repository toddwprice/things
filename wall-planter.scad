$fn=64;

// wall planter
wood_depth = 65;
wood_length = 200;
wood_angle = 58;
wood_thickness = 6;
glass_depth = wood_depth * 0.9;
glass_thickness = 0.8;
glass_height = 50;
slot_x = glass_thickness + 0.2;
slot_y = sin(wood_angle/2) * glass_height;
slot_z = 0.4;
hole_diameter = 2;
hole_offset = 3;


module plank(back_notch = false) {
  difference() {
    // wood plank face
    cube([wood_depth, wood_length, wood_thickness]);

    // notch
    z_offset = back_notch ? -.01 : wood_thickness - slot_z + .01;
    translate([(wood_depth - glass_depth) / 2, 0, z_offset])
    #cube([slot_x, slot_y, slot_z]);

    // hanger hole
    translate([(wood_depth - hole_diameter/2) / 2, wood_length - hole_offset, -.01])
    #cylinder(h=wood_thickness + 0.02, r=hole_diameter/2);
  }
}

union() {
  plank();

  rotate(wood_angle, [1,0,0])
  plank(true);
}

