include <ISOThread.scad>;

block_z = 20;
block_x = 16;
block_y = 16;
thread_size = 10;
thread_length = block_z * 2/3;
bolt_length = 30;

$fn=100;

translate([0,0,block_z + bolt_length + 20]) 
rotate(180, [1,0,0]) 
hex_bolt(thread_size,bolt_length);

union() {
  difference() {
    translate([0,0,block_z/2])
    cube(size = [block_x, block_y, block_z], center=true);

    translate([0,0,block_z - thread_length]) 
    cylinder(r = (thread_size/2),h = thread_length*1.1);
  }

  translate([0,0, block_z - thread_length]) 
  thread_in(thread_size, thread_length);
}
