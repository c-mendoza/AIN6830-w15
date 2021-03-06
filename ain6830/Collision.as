﻿package ain6830 {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	//Class Collision
	//Based on code by Rex van der Spuy, originally in Foundation Game Design with Flash
	//AIN 6830 – Winter 15 Version 1.0
	//Cristobal Mendoza.
	
	public class Collision {
		public static const COLLISION_NONE: uint = 0;
		public static const COLLISION_SIDE_LEFT: uint = 1;
		public static const COLLISION_SIDE_RIGHT: uint = 2;
		public static const COLLISION_SIDE_TOP: uint = 3;
		public static const COLLISION_SIDE_BOTTOM: uint = 4;
		
		
		public function Collision() {}
		
		//Check axis-aligned collisions between two DisplayObjects.
		//Returns uint indicating the side of the collision of objectA, or 0 if no collision occurs.
		static public function checkCollision(objectA: DisplayObject, objectB: DisplayObject): uint {
			var objectA_Halfwidth: Number = objectA.width / 2;
			var objectA_Halfheight: Number = objectA.height / 2;
			var objectB_Halfwidth: Number = objectB.width / 2;
			var objectB_Halfheight: Number = objectB.height / 2;
			var dx: Number = objectB.x - objectA.x;
			var ox: Number = objectB_Halfwidth + objectA_Halfwidth - Math.abs(dx);
			if (ox > 0) {
				var dy: Number = objectA.y - objectB.y;
				var oy: Number = objectB_Halfheight + objectA_Halfheight - Math.abs(dy);
				if (oy > 0) {
					if (ox < oy) {
						if (dx < 0) { //Collision on right
							return COLLISION_SIDE_RIGHT;
						} else { //Collision on left
							return COLLISION_SIDE_LEFT;
						}
					} else {
						if (dy < 0) { //Collision on Top
							return COLLISION_SIDE_TOP;
						} else { //Collision on Bottom
							return COLLISION_SIDE_BOTTOM;
						}
					}
				}
			}
			
			return COLLISION_NONE;
		}
		
		//Block the movement of a moving DisplayObject if it is in collision with a stationary DisplayObject.
		//Returns a uint indicating which side of the movingObject was in collision, or 0 if there was no collision.
		//See the class's COLLISION_SIDE constants for possible return values.
		static public function block(movingObject: DisplayObject, staticObject: DisplayObject): uint {
			
			var collisionSide = COLLISION_NONE;
			
			var objectA_Halfwidth: Number = movingObject.width / 2;
			var objectA_Halfheight: Number = movingObject.height / 2;
			var objectB_Halfwidth: Number = staticObject.width / 2;
			var objectB_Halfheight: Number = staticObject.height / 2;
			var dx: Number = staticObject.x - movingObject.x;
			var ox: Number = objectB_Halfwidth + objectA_Halfwidth - Math.abs(dx);
			
			var player = movingObject as Player;
			
			
			
			if (ox > 0) {
				var dy: Number = staticObject.y - movingObject.y;
				var oy: Number = objectB_Halfheight + objectA_Halfheight - Math.abs(dy);
				if (oy > 0) {
					if (ox < oy) {
						if (dx < 0) { //Collision on right
							oy = 0;
							collisionSide = COLLISION_SIDE_LEFT;
							player.setX(movingObject.x + ox);
						} else { //Collision on left
							oy = 0;
							ox *= -1;
							collisionSide = COLLISION_SIDE_RIGHT;
							player.setX(movingObject.x + ox);
						}
					} else {
						if (dy < 0) { //Collision on Top
							ox = 0;
							collisionSide = COLLISION_SIDE_TOP;
							player.setY(movingObject.y + oy);
							
						} else { //Collision on Bottom
							ox = 0;
							oy *= -1
							collisionSide = COLLISION_SIDE_BOTTOM;
							player.setY(movingObject.y + oy);
						}
					}
				}
			}
			//Return the side of the collision
			return collisionSide;
		}
		
		static public function playerAndPlatform(player:PlatformPlayer, platform:Platform) {
			
			var collisionSide = COLLISION_NONE;
			
			var objectA_Halfwidth: Number = player.width / 2;
			var objectA_Halfheight: Number = player.height / 2;
			var objectB_Halfwidth: Number = platform.width / 2;
			var objectB_Halfheight: Number = platform.height / 2;
			var dx: Number = platform.x - player.x;
			var ox: Number = objectB_Halfwidth + objectA_Halfwidth - Math.abs(dx);
			
			
			if (ox > 0) {
				var dy: Number = platform.y - player.y;
				var oy: Number = objectB_Halfheight + objectA_Halfheight - Math.abs(dy);
				if (oy > 0) {
					if (ox < oy) {
						if (dx < 0) { //Collision on right
							oy = 0;
							collisionSide = COLLISION_SIDE_LEFT;
//							player.addForceX(-player.forceX);
							player.setX(player.x + ox);
						} else { //Collision on left
							oy = 0;
							ox *= -1;
							collisionSide = COLLISION_SIDE_RIGHT;
//							player.addForceX(-player.forceX);
							player.setX(player.x + ox);
						}
					} else {
						if (dy < 0) { //Collision on Top
							ox = 0;
							collisionSide = COLLISION_SIDE_TOP;
//							player.addForceY(-player.forceY);
							player.setY(player.y + oy);
//							trace("top");
						} else { //Collision on Bottom
							if(player.vy >= 0) {
								ox = 0;
								oy *= -1;
								collisionSide = COLLISION_SIDE_BOTTOM;
								player.setY(player.y + oy);
								//Super kludge to make moving platforms behave
								if(platform is MovingPlatform) {
									player.setY(player.y + 3);
									player.addForceY(3);
									//Here be the kludge, so that the camera tracks the player:
									player.vy = (platform as MovingPlatform).vy;
									
									
//									player.setX(player.x + (platform as MovingPlatform).vx);
									player.addForceX((platform as MovingPlatform).vx * (player.frictionX));
//									var xForce = (platform as MovingPlatform).vx - player.forceX - (player.frictionX * player.vx);
//									trace(xForce);
//									player.addForceX(xForce);
//									player.vx = (platform as MovingPlatform).vx;
									
								}
								player.canJump = true;
								player.inAir = false;
							}
						}
					}
				}
			}
			//Return the side of the collision
			return collisionSide;
		}
		
		//General purpose method for testing Axis-based collisions. Returns true or false
		static public function test(objectA: Object, objectB: Object): Boolean {
			var objectA_Halfwidth = objectA.width / 2;
			var objectA_Halfheight = objectA.height / 2;
			var objectB_Halfwidth = objectB.width / 2;
			var objectB_Halfheight = objectB.height / 2;
			var dx = objectB.x - objectA.x;
			var ox = objectB_Halfwidth + objectA_Halfwidth - Math.abs(dx);
			if (0 < ox) {
				var dy = objectA.y - objectB.y;
				var oy = objectB_Halfheight + objectA_Halfheight - Math.abs(dy);
				if (0 < oy) {
					return true;
				}
			} else {
				return false;
			}
			return false;
		}
	}
}