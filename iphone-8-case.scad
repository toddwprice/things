include <modules.scad>;

$fs = 0.01;   // Set to 0.01 for higher definition curves (renders slower)
$fn = 96;     // Set to multiples of 4

// =============== VARIABLES ===============
case_wall_thickness = 1.6;          // thickness of the case wall
phone_width = 67.0;                 // width of phone (x)
phone_height = 138.0;               // height of phone (y)
phone_thickness = 7.6;              // thickness of phone (z)
corner_radius = 5.5;                // corner radius
button_width = 11.3;                // width of buttons (rotated x)
button_height = 3.1;                // height of buttons (rotated y)
button_thickness = .20;             // thickness of buttons
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
gap_x = 0.2;
gap_y = 0.2;
gap_z = 0.0;

// =============== CALCULATIONS ===============
case_width = phone_width + gap_x*2 + case_wall_thickness*2;
case_height = phone_height + gap_y*2 + case_wall_thickness*2;
case_thickness = phone_thickness + gap_z + case_wall_thickness*2;
button_z = ((case_thickness - button_height) / 2);
mute_cutout_z = (case_thickness - mute_switch_cutout_height) / 2;
bottom_cutout_width = phone_width * 0.875;
glass_width = phone_width - 3;
glass_height = phone_height - 3;

// =============== MAIN ===============
difference() {
  union() {
    case();
    // volume up
    translate([-button_thickness,case_height - volume_up_position, button_z]) button();
    // volume down
    translate([-button_thickness,case_height - volume_down_position, button_z]) button();
    // power button
    translate([button_thickness + case_width,case_height - power_position + button_width, button_z]) rotate(180, [0,0,1]) button();
  }

  // mute switch cutout
  translate([-0.01,case_height - mute_cutout_position, mute_cutout_z])
  rotate(90, [0,0,1]) 
  rotate(90, [1,0,0]) 
  cutout(mute_switch_cutout_width, mute_switch_cutout_height, case_thickness/2);

  // bottom cutout
  translate([(case_width - bottom_cutout_width)/2, -10, 2])
  translate([corner_radius, corner_radius, corner_radius])
  minkowski() {
    cube([bottom_cutout_width - corner_radius*2, case_height/2, case_thickness]);
    sphere(r=corner_radius, $fn=80);
  }

  // edge shaver
  #edge_shaver(3,10,1);
  // *translate([(case_width - bottom_cutout_width)/2, shaver_radius, case_thickness])
  // sphere(r=shaver_radius);

  // back camera cutout
  translate([gap_x + back_camera_position_x, case_height - gap_y - back_camera_position_y - back_camera_cutout_height, -case_thickness/4])
  cutout(back_camera_cutout_width, back_camera_cutout_height, case_thickness/2);

  // volume up button cutout
  translate([.1,case_height - volume_up_position,button_z]) button(case_wall_thickness);

  // volume down button cutout
  translate([.1,case_height - volume_down_position,button_z]) button(case_wall_thickness);

  // power button cutout
  translate([case_width - 0.1,case_height - power_position + button_width, button_z]) rotate(180, [0,0,1]) button(case_wall_thickness);

  // // phone cutout - make sure there's room for the phone all around!
  // *translate([gap_x, gap_y, gap_z])
  // cube_round(phone_width, phone_height, phone_thickness, corner_radius);
}

