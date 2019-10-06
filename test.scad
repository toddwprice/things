// variables
case_wall_thickness = 1.6;
phone_width = 67.0;
phone_height = 138.0;
phone_thickness = 7.6;
corner_radius = 5.5;
button_width = 11.3;
button_height = 3.1;
button_thickness = .20;
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
// case_width = 69.8;
// case_height = 139.3;
// case_thickness = 9.5;
gap_x = 0.2;
gap_y = 0.2;
gap_z = 0.2;


// calculations
case_width = phone_width + gap_x*2 + case_wall_thickness*2;
case_height = phone_height + gap_y*2 + case_wall_thickness*2;
case_thickness = phone_thickness + gap_z + case_wall_thickness*2;
button_z = ((case_thickness - button_height) / 2);
mute_cutout_z = (case_thickness - mute_switch_cutout_height) / 2;
bottom_cutout_width = phone_width * 0.875;

echo(case_width);
echo(case_height);
echo(case_thickness);

module cube_round(x, y, z, r) {
  translate([r,r,r])
  minkowski() {
    cube([x-r*2,y-r*2, (z - r*2 > 0) ? z - r*2 : .01]);
    sphere(r=r, $fn=80);
  }
}


// zp = corner_radius*2 / case_thickness;
// echo(zp);

// cube_round(case_width, case_height, 6, 3, 1);

x = 70.6;
y = 141.6;
z = 11;
r = 1.5;

// translate([r,r,r])
// minkowski() {
//   cube([x-r*2,y-r*2, (z - r*2 > 0) ? z - r*2 : .01]);
//   sphere(r=r, $fn=80);
// }

cube_round(x,y,z,r);
#translate([0,0,case_thickness]) cube([case_width, case_height, .1]);
#cube([case_width, case_height, .1]);