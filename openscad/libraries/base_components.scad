BC_OPT_LEGSZ = 5;
BC_OPT_ADDSZ = .5;
BC_OPT_POIDIA = 1.5;

// Battery
module Bat18650Half(center = false){
  if(center == false)
    cylinder(38, d = 17);
  else
    translate([0, 0, -38 / 2])
    cylinder(38, d = 17);  
}

// DIP
module DIP8(legsz = BC_OPT_LEGSZ, addsz = BC_OPT_ADDSZ){
  SX = 9.4 + addsz;
  SY = 6.2 + .8 + addsz;
  SZ = 5;
  
  translate([-SX / 2, -SY / 2, 0])
    cube([SX, SY, SZ]);
  
  for(x = [-1.5, -.5, .5, 1.5])
    for(y = [-1, 1])
    translate([x * 2.54, y * 7.62 / 2, -legsz])
    cylinder(legsz + 5, d = BC_OPT_POIDIA);
}

// POI
module BcPoi(x, y, dia = BC_OPT_POIDIA, legsz = BC_OPT_LEGSZ){
  translate([x, y, -legsz])
    cylinder(legsz, d = dia);
}

// Switch
module BcSwitch7x7(pox_x = 0, pos_y = 0){
  for(x = [-2.54 : 5.08 : 2.54])
    for(y = [-1.9 : 1.9 : 1.9])
      BcPoi(x, y);
}

module BcSwitch7x7Full(add = .2, legsz = 3, up = 0, leg_dia = BC_OPT_POIDIA){
  sz = 7 + add;
  
  translate([-sz / 2, -sz / 2, 0])
  cube([sz, sz, sz + up]);
  
  translate([0, 0, -legsz])
  for(x = [-2.54 : 5.08 : 2.54])
    for(y = [-1.9 : 1.9 : 1.9])
      translate([x, y, 0])
      cylinder(legsz, d = leg_dia);
      //Poi(x, y);
}

module BcLed3mm(legsz = BC_OPT_LEGSZ){
  cylinder(5, d = 3);
  cylinder(1, d = 4.0);
  
  for(x = [-1, 1])
    translate([x * 1.27, 0, -leg_sz])
    cylinder(leg_sz, d = 1);
}

module BcLed5mm(legsz = BC_OPT_LEGSZ){
  cylinder(5, d = 5);
  cylinder(1, d = 6.0);
  
  for(x = [-1, 1])
    translate([x * 1.27, 0, -legsz])
    cylinder(legsz, d = 1);
}