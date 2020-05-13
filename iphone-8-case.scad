include <modules.scad>;

$fs = 0.01;   // Set to 0.01 for higher definition curves (renders slower)
$fn = 96;     // Set to multiples of 4

// =============== VARIABLES ===============
case_wall_thickness = 1.2;          // thickness of the case wall
phone_width = 67.3;                 // width of phone (x)
phone_height = 138.4;               // height of phone (y)
phone_thickness = 7.3;              // thickness of phone (z)
corner_radius = 5.5;                // corner radius
button_width = 11.3;                // width of buttons (rotated x)
button_height = 3.1;                // height of buttons (rotated y)
button_thickness = .20;             // thickness of buttons
mute_switch_cutout_width = 42;       
mute_switch_cutout_height = 4.5;
mute_cutout_position = 56;
volume_up_position = 32;
volume_down_position = 45;
power_position = 43.5;
power_cutout_width = 15.5;
back_camera_cutout_width = 24.3;
back_camera_cutout_height = 12.5;
back_camera_position_x = 40.4;
back_camera_position_y = 5.5;
gap_x = 0.0;
gap_y = 0.0;
gap_z = 0.0;
edge_radius = 11;

// =============== CALCULATIONS ===============
case_width = phone_width + gap_x*2 + case_wall_thickness*2;
case_height = phone_height + gap_y*2 + case_wall_thickness*2;
case_thickness = phone_thickness + gap_z + case_wall_thickness;
button_z = ((case_thickness - button_height) / 2);
mute_cutout_z = (case_thickness - mute_switch_cutout_height) / 2;
power_cutout_z = mute_cutout_z + .3;
bottom_cutout_width = phone_width * 0.875;
glass_width = phone_width - 5;
glass_height = phone_height - 5;

module shell(width, height, thickness, radius) {
  difference() {
    translate([radius, radius, 0])
    minkowski() {
      cube([width - radius*2, height - radius*2, thickness]);
      cylinder(r=radius);
    }

    // cut off height above needed z
    translate([-1,-1,thickness])
    cube([width + 2, height + 2, thickness]);
  }
}

module base_case() {
  difference() {
    shell(case_width, case_height, case_thickness, edge_radius);
    
    // inner space
    translate([case_wall_thickness + gap_x, case_wall_thickness + gap_y, case_wall_thickness]) 
    shell(case_width - case_wall_thickness*2, case_height - case_wall_thickness*2, case_thickness - case_wall_thickness*2, edge_radius);

    // glass window breakthrough
    translate([(case_width - glass_width) / 2, (case_height - glass_height) / 2, case_thickness / 2])
    shell(glass_width, glass_height, case_thickness, edge_radius);

    // TOP BEVEL
    // left side bevel
    translate([-sin(45)*case_thickness,0, sin(45)*case_thickness * 2.2])
    rotate(45, [0,1,0])
    cube([case_thickness, case_height, case_thickness]);

    // right side bevel
    translate([case_width - sin(45)*case_thickness,0, sin(45)*case_thickness * 2.2])
    rotate(45, [0,1,0])
    cube([case_thickness, case_height, case_thickness]);

    // bottom side bevel
    translate([0,0, sin(45)*case_thickness*1.2])
    rotate(45, [1,0,0])
    cube([case_width, case_thickness, case_thickness]);

    // top side bevel
    translate([0, case_height, sin(45)*case_thickness*1.2])
    rotate(45, [1,0,0])
    cube([case_width, case_thickness, case_thickness]);

    // // SE corner bevel
    // translate([case_width + sin(45)*case_thickness, sin(45)*case_thickness, sin(45)*case_thickness*.4])
    // rotate(45, [0,0,1])
    // rotate(45, [1,0,0])
    // translate([-case_width/4, 0, 0])
    // cube([case_width/2, case_thickness, case_thickness]);

    // // BOTTOM BEVEL
    // left side bevel
    translate([-sin(45)*case_thickness,0, case_thickness - sin(45)*case_thickness * 2.2])
    rotate(45, [0,1,0])
    cube([case_thickness, case_height, case_thickness]);

    // right side bevel
    translate([case_width - sin(45)*case_thickness,0, case_thickness - sin(45)*case_thickness * 2.2])
    rotate(45, [0,1,0])
    cube([case_thickness, case_height, case_thickness]);

    // bottom side bevel
    translate([0,0, case_thickness - sin(45)*case_thickness * 3.2])
    rotate(45, [1,0,0])
    cube([case_width, case_thickness, case_thickness]);

    // top side bevel
    translate([0, case_height, case_thickness - sin(45)*case_thickness * 3.2])
    rotate(45, [1,0,0])
    cube([case_width, case_thickness, case_thickness]);


    // mute and volume switches cutout
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

    // back camera cutout
    translate([gap_x + back_camera_position_x, case_height - gap_y - back_camera_position_y - back_camera_cutout_height, -case_thickness/4])
    cutout(back_camera_cutout_width, back_camera_cutout_height, case_thickness/2);

    // power button cutout
    translate([case_width - case_wall_thickness - .01, case_height - power_position, power_cutout_z])
    rotate(90, [0,0,1]) 
    rotate(90, [1,0,0])
    cutout(power_cutout_width, mute_switch_cutout_height, case_thickness/2);
  }
}

difference() {
  base_case();

  translate([55,-5,-.01])
  linear_extrude(height=case_wall_thickness * 0.70)
  rotate(60, [0,0,1])
  import(file="leaf.svg", center=false, dpi=100);
}

// color("white")
// translate([case_wall_thickness, phone_height + case_wall_thickness, 0])
// rotate(180, [0,0,1]) 
// rotate(180, [0,1,0]) 
// rotate(-90, [1,0,0]) 
// import("iphone-8-phone-2.stl");
