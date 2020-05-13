
color("white")
translate([0,-30,0])
cube([90,90,0.6]);

translate([5,7,0.59])
linear_extrude(height=0.60)
union() {
  translate([0,30])
  text("Happy", font="Gloria Hallelujah:style=Regular", size=10);

  translate([10,15])
  text("Palindrome", font="Gloria Hallelujah:style=Regular", size=10);

  translate([20,0])
  text("Day", font="Gloria Hallelujah:style=Regular", size=10);

  translate([0,-25])
  text("02/02/2020", font="Gloria Hallelujah:style=Regular", size=10);
}
