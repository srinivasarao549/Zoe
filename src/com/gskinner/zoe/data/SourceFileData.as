/*
* Zoë by gskinner.com.
*
* Copyright (c) 2010 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

package com.gskinner.zoe.data {
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.escapeMultiByte;
	import flash.utils.unescapeMultiByte;
	
	/**
	 * VO to hold settings for individual SWF files
	 * used to define each row in the main file dropdown 
	 * 
	 */
	public class SourceFileData {
		
		/**
		 * The total number of frames to capture (0 means capture all)
		 */
		public var frameCount:Number;
		
		/**
		 * The maximum width of the bitmap to export
		 */
		public var bitmapWidth:Number;
		
		/**
		 * The maximum height of the bitmap to export
		 */
		public var bitmapHeight:Number;
		
		/**
		 * Background color to display behind the animation.
		 */
		public var backgroundColor:uint;
		
		/**
		 * Shows or hides the transparency grid behind the animation.
		 */
		public var showGrid:Boolean;
		
		/**
		 * The bounds to capture from the loaded animation.
		 */
		public var frameBounds:Rectangle;
		
		/**
		 * Extra padding to apply to the frameBound upon export (will not visually display)
		 */
		public var exportPadding:Number;
		
		/**
		 * The absolute URI to the swf
		 */
		public var sourcePath:String;
		
		/**
		 * Sets the image format to be exported. (A full SpriteSheet, or individual frames)
		 * 
		 */
		public var imageExportType:String;
		
		/**
		 * Specifies whether there JSON source should be exported or not.
		 */
		public var dataExportType:String;
		
		/**
		 * Specifies threshold level for comparing Bitmapdata.
		 */
		public var threshold:Number;
		
		/**
		 * Specifies reuse frames.
		 */
		public var reuseFrames:Boolean;
		
		/**
		 * @private
		 */
		protected var _name:String;
		
		/**
		 * @private
		 */
		protected var _destinationPath:String;
		
		/**
		 * @private
		 */
		public var registrationPt:Point;
		
		/**
		 * @private
		 */
		public var displayPt:Point;
		
		/**
		 * @private
		 */
		public var variableFrameDimensions:Boolean;
		
		/**
		 * @private
		 */
		public var isDirty:Boolean = true;
		
		/**
		 * Creates a new SourceFileData instance
		 * 
		 */
		public function SourceFileData() {
			frameBounds = new Rectangle();
			backgroundColor = 0xcccccc;
			showGrid = true;
			exportPadding = 0;
			frameCount = 0;
		}
		
		/**
		 * The name to use for export and display in the main ui.
		 * 
		 */
		public function set name(value:String):void {
			_name = escapeMultiByte(value);
		}
		public function get name():String {
			return unescapeMultiByte(_name);
		}
		
		/**
		 * Defines the output folder to save captured assets.
		 * 
		 */
		public function set destinationPath(value:String):void {
			_destinationPath = escapeMultiByte(value);
		}
		public function get destinationPath():String {
			return unescapeMultiByte(_destinationPath);
		}
		
		/**
		 * Convert to an generic object, so we can save as AMF to the file system.
		 * 
		 */
		public function serialize():Object {
			
			var obj:Object = {
				bitmapWidth:bitmapWidth,
				bitmapHeight:bitmapHeight,
				backgroundColor:backgroundColor,
				showGrid:showGrid,
				frameBounds:{x:frameBounds.x, y:frameBounds.y, width:frameBounds.width, height:frameBounds.height},
				exportPadding:exportPadding,
				destinationPath:destinationPath,
				sourcePath:sourcePath,
				name:name,
				threshold:threshold,
				
				imageExportType:imageExportType,
				dataExportType:dataExportType,
				
				reuseFrames:reuseFrames,
				registrationPt:registrationPt,
				variableFrameDimensions:variableFrameDimensions,
				displayPt:displayPt,
				frameCount:frameCount,
				isDirty:isDirty
			}
			
			return obj;
		}
		
		/**
		 * Converts our saved data into valid properties.
		 * 
		 */
		public function deserialize(value:Object):void {
			bitmapWidth = value.bitmapWidth;
			bitmapHeight = value.bitmapHeight;
			backgroundColor = value.backgroundColor;
			showGrid = value.showGrid;
			frameBounds = new Rectangle(value.frameBounds.x,value.frameBounds.y,value.frameBounds.width,value.frameBounds.height);
			exportPadding = value.exportPadding;
			destinationPath = value.destinationPath;
			sourcePath = value.sourcePath;
			name = value.name;
			displayPt = (value.displayPt!= null) ? new Point(value.displayPt.x, value.displayPt.y) : new Point(0, 0);
			variableFrameDimensions = value.variableFrameDimensions;
			registrationPt = (value.registrationPt != null) ? new Point(value.registrationPt.x, value.registrationPt.y) : new Point(0, 0);
			threshold = isNaN(value.threshold) ? 0 : value.threshold;
			frameCount = isNaN(value.frameCount)? 0: value.frameCount;
			isDirty = value.isDirty;
			reuseFrames = value.reuseFrames;
			dataExportType = value.dataExportType || ExportType.DATA_JSON;
			imageExportType = value.imageExportType || ExportType.IMAGE_SPRITE_SHEET;
		}
	}
}