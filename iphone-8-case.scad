include <cube_round.scad>;

// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.01;
$fn = 50;

// variables
case_wall_thickness = 1.0;
case_width = 69.8;
case_height = 139.3;
case_thickness = 9.5;
phone_width = 67.0;
phone_height = 138.0;
phone_thickness = 7.6;
corner_radius = 3.5;
button_width = 11.3;
button_height = 3.1;
button_thickness = .20;
bottom_cutout_width = case_width * 0.85;
mute_switch_cutout_width = 8;
mute_switch_cutout_height = 3.5;
mute_cutout_position = 16.7;
volume_up_position = 32;
volume_down_position = 45;
power_position = 32;
back_camera_cutout_width = 24.3;
back_camera_cutout_height = 12.5;
back_camera_position_x = 40.4;
back_camera_position_y = 5.5;


// calculations
button_z = ((case_thickness - button_height) / 2);
mute_cutout_z = (case_thickness - mute_switch_cutout_height) / 2;
gap_x = (case_width - phone_width + case_wall_thickness) / 2;
gap_y = (case_height - phone_height + case_wall_thickness) / 2;
gap_z = (case_thickness - phone_thickness + case_wall_thickness) / 2;

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
    cube_round(case_width, case_height, case_thickness, corner_radius);

    translate([case_wall_thickness, case_wall_thickness, case_wall_thickness])
    cube_round(case_width - case_wall_thickness*2, case_height - case_wall_thickness*2, case_thickness, corner_radius);
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


// MAIN
difference() {
  union() {
    case();
    // volume up
    translate([-button_thickness,case_height - volume_up_position, button_z]) button();
    // volume down
    translate([-button_thickness,case_height - volume_down_position, button_z]) button();
    // power button
    translate([button_thickness + case_width + 2,case_height - power_position + button_width, button_z]) rotate(180, [0,0,1]) button();
  }

  // mute switch cutout
  translate([-0.01,case_height - mute_cutout_position, mute_cutout_z])
  rotate(90, [0,0,1]) 
  rotate(90, [1,0,0]) 
  cutout(mute_switch_cutout_width, mute_switch_cutout_height, case_thickness/2);

  // bottom cutout
  translate([(case_width - bottom_cutout_width)/2, -10, 2])
  cube_round(bottom_cutout_width, case_height/2, case_thickness*2, corner_radius);

  // back camera cutout
  translate([gap_x + back_camera_position_x, case_height - gap_y - back_camera_position_y - back_camera_cutout_height, -case_thickness/4])
  cutout(back_camera_cutout_width, back_camera_cutout_height, case_thickness/2);

  // volume up button cutout
  translate([.01,case_height - volume_up_position,button_z]) button(2);

  // volume down button cutout
  translate([1,case_height - volume_down_position,button_z]) button();

  // power button cutout
  translate([case_width - case_wall_thickness - 0.1,case_height - power_position + button_width, button_z]) rotate(180, [0,0,1]) button();

  // phone cutout - make sure there's room for the phone all around!
  translate([gap_x, gap_y, gap_z])
  cube_round(phone_width, phone_height, phone_thickness, corner_radius);
  // linear_extrude(height=phone_thickness)
  // rounded_rectangle(phone_width, phone_height, corner_radius);
}

