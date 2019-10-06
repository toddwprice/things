
module bracket() {
	$fn=100;
	union() {
		translate([0,0,bracket_height-bracket_arm_thickness]) cube([bracket_width-3, bracket_arm_width, bracket_arm_thickness]);
		cube([bracket_width-3, bracket_arm_width, bracket_arm_thickness]);

		translate([-bracket_height,0,bracket_height/2])
		difference() {
			rotate(-90, [1,0,0])
			difference() {
				cylinder(r=bracket_height*2, h=bracket_arm_width);
				translate([0,0,-.01]) cylinder(r=bracket_height*2 - bracket_arm_thickness, h=bracket_arm_width+.02);
			}
			translate([-bracket_height*2,-.01,bracket_height/2]) cube([bracket_height*4, bracket_arm_width*2, bracket_height*2]);
			translate([-bracket_height*2,-.01,-bracket_height*2 - bracket_height/2]) cube([bracket_height*4, bracket_arm_width*2, bracket_height*2]);
			translate([-bracket_height*2,-.01,-bracket_height/2 -1]) cube([bracket_height, bracket_arm_width*2, bracket_height*2]);
		}
	}
}
