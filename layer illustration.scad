height = 2.5;
layer_height = .1;
width = .42;
overhang = 0;

full_step_length = 25.4 / 18 / 200;
wobble_amplitude = .01;
wobble_period = 25.4 / 18;
diametric_tolerance = .01;

//area = layer_height * width;
area = layer_height * width * rands(1 - diametric_tolerance, 1 + diametric_tolerance, height / layer_height, 42);



pi = 3.14159;
$fs = .02;

rotate([90, 0, 0]) {
	for(layer = [0:height / layer_height - 1]) assign(bottom = full_step_length * round(layer * layer_height / full_step_length), top = full_step_length * round((layer + 1) * layer_height / full_step_length)) {
		translate([wobble_amplitude * sin(360 * bottom / wobble_period) + bottom * tan(overhang), bottom + (top - bottom) / 2, 0]) thread(top - bottom, area[layer]);
	}
	%translate([-width / 2 - layer_height * tan(overhang) / 2, 0, -.02]) hull() {
		square([width, .002]);
		translate([height * tan(overhang), height - .01, 0]) square([width, .002]);
	}
}

module thread(h = .3, a = area(.35)) {
	spread = (a - area(h)) / h;
	hull() for(side = [1, -1]) translate([side * spread / 2, 0, 0]) circle(h / 2 - .0005);
}

function area(d) = pi * pow(d / 2, 2);