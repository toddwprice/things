$fn=100;

module thing() {    
    render()    
    minkowski() {
        cylinder(r1=12, r2=5, h=12);
        cube(5);
        sphere(10);
    }
}

module blob() {
    difference() {
        union() {
            thing();
            translate([10,20,5]) thing();
            translate([20,10,-5]) thing();
            translate([40,10,-15]) thing();
            translate([30,-10,-10]) thing();
        }
    }
}

module cutter() {
    difference() {
        thing();
        scale([0.95, 0.95, 0.95]) thing();
    }
}
blob();