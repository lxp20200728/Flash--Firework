package
{
	import flash.display.Sprite;
	
	public class Firework extends Sprite
	{
		
		/**
		 * 烟花发射的速度
		 */
		private var _speed:int;
		/**
		 * 烟花的颜色
		 */
		private var _color:int;
		/**
		 * 烟花发射的密度
		 */
		private var _interval:int;
		
		
		public function Firework()
		{

		}
		
		public function update():void
		{
            var raiseMovie:RaiseMovie = new RaiseMovie();

		}
		


		public function get speed():int
		{
			return _speed;
		}

		public function set speed(value:int):void
		{
			_speed = value;
		}

		public function get color():int
		{
			return _color;
		}

		public function set color(value:int):void
		{
			_color = value;
		}

		public function get interval():int
		{
			return _interval;
		}

		public function set interval(value:int):void
		{
			_interval = value;
		}


	}
}