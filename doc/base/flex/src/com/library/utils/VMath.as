package com.library.utils{
	public class VMath{
		public static function randon(min:Number, max:Number):Number{
			return Math.round( Math.random()*(max-min) )+min;
		}
	}
}