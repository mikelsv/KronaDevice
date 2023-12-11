include <../libraries/base_components.scad>
$fn = 32;

// Version 1.1 (11.12.2023)

// Configure
// 0 - Main Board
// 1 - Logic board
// 2 - Drill board

MODE = 0; // 0, 1, 2.

if(MODE == 0)
  MainBoard();
else if(MODE == 1)
  LogicBoard();
else if(MODE == 2)
  LogicBoard(2);

module MainBoard(){
  SX = 45;
  SY = 26;
  SZ = 3;
  SDZ = 2.5;
  SDZL = SDZ - .2;
  BUT_UP = 1.2;
  
  difference(){
    union(){
      // Board
      translate([-SX / 2, -SY / 2, -SDZ])
        cube([SX, SY, SZ + SDZ]);
      
      // SY wall
      translate([-SX / 2, -SY / 2, 0])
      cube([SX, 2, 6]);
      
      // Battery wall
      translate([-22.5, -4, 5 + BUT_UP])
      rotate([0, 90, 0])
      cylinder(2.0, d = 17);
      
      *translate([+18, 4, 5 + BUT_UP])
      rotate([0, 90, 0])
      cylinder(3.5, d = 17);
    }
    
    // Battery
    translate([0, -4, 5 + BUT_UP])
    rotate([0, 90, 0])
      Bat18650Half(center = true);
    
    // Battery VCC+
          // Battery wall
      translate([-22.5, -4, 5 + BUT_UP])
      rotate([0, 90, 0]){
          translate([0, 0, 2])
          cylinder(2.0, d = 17);

          translate([0, 0, 1])
          #cylinder(1.0, d = 7.5);

          #cylinder(1.0, d = 2.2);
      
      }
    
    // Crona connecter
    translate([20, -25 / 2, -2])
    cube([2, 25, 20]);
    
    // Logic Board
    #translate([-6, 8, 6])
    rotate([90, 0, 180])
    LogicBoard(FILL = 1);    
  }
}

module LogicBoard(FILL = 0){
  SX = 32;
  MX = -4;
  SY = 17;
  SZ = 2;
  SDZ = 2;
  SDZL = SDZ - .2;

  if(FILL == 1){  
    FSX = SX + .5;
    FSY = SY + .5;
    BS = 7 + .5;
    
    // Board
    translate([-FSX / 2 + MX, -FSY / 2, -SDZ])
      cube([FSX, FSY, SZ + SDZ]);  
    
    translate([-14, -5, 0])
    translate([-BS / 2, -3.5, -BS / 2])
    cube([BS + 22, 7, BS]);
    
    translate([-14 + 9, -5, 2])
    translate([-BS / 2, -3.5, -BS / 2])
    cube([BS + 12.5, 7, BS]);
  } else if(FILL == 2){
    FSX = SX;// + .5;
    FSY = SY;// + .5;
    BS = 7;// + .5;
    
    difference(){
      union(){
        // Board
        translate([-FSX / 2 + MX, -FSY / 2, -SDZ])
          cube([FSX, FSY - 5, SZ + SDZ]);
        
        translate([-14, -5, 0])
        translate([-BS / 2, -3.75, -BS / 2])
        cube([BS + 22, 7, BS]);
        
        *translate([-14 + 9, -5, 2])
        translate([-BS / 2, -3.75, -BS / 2])
        cube([BS + 12.5, 7, BS]);
      }
      
      // Drill hole 7x7
      translate([-14, 11.5, 0])
        rotate([90, 0, 0]){
          *#cylinder(20, d = 1.5);
          
          #translate([0, 0, +1.0])
          cylinder(20, d = 4);          
        }
        
      // Drill hole led 3mm
      translate([-8, 11.5, 0])
        rotate([90, 0, 0]){
          *#cylinder(20, d = 1.5);
          
          #translate([0, 0, +1])
          cylinder(20, d = 3);          
        }      
    }
  } else

  difference(){
    union(){
    // Board
    translate([-SX / 2 + MX, -SY / 2, -SDZ])
      cube([SX, SY, SZ + SDZ]);
      
      // Switch case
      translate([-17.5, -5, 0])
      cube([7, 5.5, 3.5]);
    }
   
    // MC34063
    DIP8(legsz = SDZL);
    
    // Holes
    for(x = [-1.5, -.5, .5, 1.5])
    for(y = [-1, 1])
    translate([x * 2.54, y * 6.35, -SDZL])
    cylinder(5 + 5, d = 1.5);
      
     *translate([2.54 * 1.5, -6.35, -SDZL + 1])
      cylinder(10, d = 3);
    
    // Power
    for(y = [1])
    translate([-7, y * 2.54, -SDZL])
      cylinder(10, d = 1.5);
    
    // Result
    for(rc = [[0, -1], [0, 1], [1, -1], [1, 1], [.5, -1.5], [.5, 1.5]])
    //for(x = [0, 1])
    //for(y = [-1, 1])
    translate([7 + rc[0] * 2.54, rc[1] * 2.54, -SDZL])
      cylinder(10, d = 1.5);

    // Switch
    translate([-14, -2, 0])
    rotate([90, 90, 0])
    #BcSwitch7x7Full(legsz = 4);
    
    // + Wire contact
    translate([-14, 3.0, -SDZL])
      cylinder(10, d = 1.5);
    
    // Led
    translate([-7-1, -8, 0])
    rotate([90, 90, 0])
    BcLed3mmMod(legsz = 13);
    
    // Led to Power
    line([-8, -1, SZ - .5], [-12, 3, SZ], .5);
    
    // Led resistor
    *translate([-10, 2.5, -SDZL])
      cylinder(10, d = 1.5);
    // + Body
    translate([-7, 2.5, -SDZL + 1])
      cylinder(10, d = 3);
  }  
}

module BcLed3mmMod(legsz = BC_OPT_LEGSZ){
  cylinder(5, d = 3);
  cylinder(1, d = 4.5);
  
  for(x = [-1, 1]){
    translate([x * 1.27, 0, -legsz - x * 6])
    cylinder(legsz + x * 6, d = 1);
    
    translate([x * 1.27 + x * .5, 0, -legsz -x * 6])
    cylinder(legsz + x * 6, d = 1);  
  }
}

module line(start, end, thickness = 1) {
    hull() {
        translate(start) sphere(thickness);
        translate(end) sphere(thickness);
    }
}