$fn = 64;

radius = 7;
side = 60;
z_trans = radius*2*0.18;

difference() {
  translate([0,0,z_trans])
  union() {
    rotate_extrude(convexity = 10)
    translate([side, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([side,side,0])
    rotate_extrude(convexity = 10)
    translate([side, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([0,side,0])
    rotate_extrude(convexity = 10)
    translate([side, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([side,0,0])
    rotate_extrude(convexity = 10)
    translate([side, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([0   , 0   , 0]) sphere(radius);
    translate([side, 0   , 0]) sphere(radius);
    translate([side, side, 0]) sphere(radius);
    translate([0   , side, 0]) sphere(radius);
    translate([0   , side, 0]) rotate(-60,[0,0,1]) translate([side   , 0, 0]) sphere(radius);
    rotate(30,[0,0,1]) translate([0   , -side, 0]) sphere(radius);
    rotate(120,[0,0,1]) translate([0   , -side, 0]) sphere(radius);
    rotate(150,[0,0,1]) translate([0   , -side, 0]) sphere(radius);
    rotate(240,[0,0,1]) translate([0   , -side, 0]) sphere(radius);
    translate([side, 0    , 0]) rotate(30, [0,0,1]) translate([side, 0    , 0]) sphere(radius);
    translate([0   , side , 0]) rotate(60, [0,0,1]) translate([side, 0    , 0]) sphere(radius);
    translate([side   , side , 0]) rotate(-60, [0,0,1]) translate([0   , -side    , 0]) sphere(radius);

    rotate(90, [1,0,0])
    translate([side/2,0,0])
    rotate_extrude(convexity = 10)
    translate([side/2, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([0,side,0])
    rotate(90, [1,0,0])
    translate([side/2,0,0])
    rotate_extrude(convexity = 10)
    translate([side/2, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([0,side/2,0])
    rotate(90, [1,0,0])
    translate([side/2,0,0])
    rotate_extrude(convexity = 10)
    translate([(side * cos(60))/1.3, 0, 0])
    circle(r = 2.5, $fn = 100);

    translate([30, 0, -125])
    rotate(90, [1,0,0])
    rotate_extrude(convexity = 10)
    translate([150, cos(60)*side*-1, 0])
    circle(r = 2.5, $fn = 100);
  }

  translate([-side*5,-side*5, -radius*100])
  cube([side*10, side*10, radius*100]);
}
