include <ISOThread.scad>;
include <helping_clamp_modules.scad>;

$fn=100;

wire_diameter = 3;
head_size = 20;
head_length = 20;
screw_size = 10;
screw_length = 30;
screw_thumb_height = 8;
bracket_width = 50;
bracket_height = 50;
bracket_arm_width = 24;
bracket_arm_thickness = 10;
small_screw_size = 6;
small_screw_thumb_height = 6;
small_screw_tip_length = 3;
small_screw_length = bracket_arm_width/2;

translate([0,-bracket_arm_thickness/2,bracket_arm_width/2])
rotate(90, [1,0,0])
union() {
	// bracket
	translate([0,0,bracket_arm_width/2])
	difference() {
		// bracket
		translate([-bracket_width*0.45, bracket_arm_width/2, bracket_arm_thickness]) rotate(180, [1,0,0]) bracket();
		// large screw hole
		translate([0,0,-2]) cylinder(r=screw_size/2,h=bracket_arm_thickness*1.5);
		// wire holder hole
		translate([0,0,-bracket_height + bracket_arm_thickness - .01]) cylinder(r=wire_diameter/2, h=bracket_arm_thickness*0.75);
		// small side screw hole
		translate([0,bracket_arm_width/2 + .01, bracket_arm_thickness*1.5 - bracket_height])
		rotate(90,[1,0,0])
		cylinder(r=small_screw_size/2,h=small_screw_length);
		// tip hole for side screw
		translate([0,- small_screw_tip_length +7, bracket_arm_thickness*1.5 - bracket_height])
		rotate(90,[1,0,0])
		cylinder(r=wire_diameter/2,h=small_screw_tip_length + .01);

	}

	// threads in large screw hole
	translate([0,0,bracket_arm_width/2])
	thread_in(screw_size, bracket_arm_thickness);


}

	// threads in small side screw hole
		// #translate([0,bracket_arm_width/2 + .01, 0])
	translate([0,bracket_height/2 - bracket_arm_thickness + small_screw_size/2,bracket_arm_width - small_screw_length])
	thread_in(small_screw_size, small_screw_length);


// large screw
translate([50,0,0]) 
union() {
	difference() {
		cylinder(r=screw_size,h=screw_thumb_height);
		for(i=[0:30:360]) {
			rotate(i, [0,0,1])
			translate([0,screw_size-1,-.01])
			cube([2,1,screw_thumb_height+.02]);
		}
	}

	hex_bolt(screw_size,screw_length);
}

// small screw
translate([-50,0,0]) 
union() {
	!difference() {
		union() {
			hex_bolt(small_screw_size,20);
			cylinder(r=small_screw_size,h=small_screw_thumb_height);
		}

		for(i=[0:30:360]) {
			rotate(i, [0,0,1])
			translate([-0.75,small_screw_size-1,-.01])
			cube([1.5,1,small_screw_thumb_height+.02]);
		}
	}


	translate([0,0,small_screw_length+small_screw_tip_length])
	cylinder(r=wire_diameter/2,h=small_screw_tip_length);
}

// screw plate
translate([0,50,0])
union() {
	difference() {
		cylinder(r=screw_size,h=screw_thumb_height);
		// screw notches for grippiness
		for(i=[0:30:360]) {
			rotate(i, [0,0,1])
			translate([-1,screw_size-1,screw_thumb_height*.15 +.01])
			cube([2,1,screw_thumb_height*.85]);
		}
		// thread hole
		translate([0,0,screw_thumb_height*.15 + .01]) cylinder(r=screw_size/2,h=screw_thumb_height*.85);
	}

	// threads
	translate([0,0,screw_thumb_height*.15])
	thread_in(screw_size, screw_thumb_height*.85);

}
