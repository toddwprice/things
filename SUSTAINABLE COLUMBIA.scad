// module words(offset=0) {
//     translate([3, 3, 0])
//     linear_extrude(height=5)
//     offset(delta=offset)
//     text("SUSTAINABLE COLUMBIA", font="Euphemia UCAS:style=Bold");
// }


// translate([0,25,0]) words();

// difference() {
    
//     cube([180, 20, 2]);
//     translate([0,0,0.6]) words(0.4);
// }



translate([0, 180, 0]) linear_extrude(height=5) text("SUSTA", font="Euphemia UCAS:style=Bold", size=50);
translate([0, 120, 0]) linear_extrude(height=5) text("INABL", font="Euphemia UCAS:style=Bold", size=50);
translate([0, 60, 0]) linear_extrude(height=5) text("ECOLU", font="Euphemia UCAS:style=Bold", size=50);
translate([0, 0, 0]) linear_extrude(height=5) text("MBIA", font="Euphemia UCAS:style=Bold", size=50);

 