package
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Transform;

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

    private var alphaDecrease = 0.05;
    ;
    private var count:int = 0;

    private var raiseMovieArray:Array = []; //释放烟花对象池

    private var explodeMovieArray:Array = []; // 爆炸烟花对象池

    private var curRaiseMovieArray:Array = [];

    private var curExplodeMovieArray:Array = [];
    public function Firework()
    {
        for(var i:int = 0; i < 100; i++){ //初始化对象池
            for(var j:int =0; j <30; j++){
                var explodeMovie:ExplodeMovie = new ExplodeMovie();
                explodeMovie.x = explodeMovie.y = 0;  // 初始化高度
                explodeMovieArray.push(explodeMovie);
            }
            var raiseMovie:RaiseMovie = new RaiseMovie();
            raiseMovie.x = raiseMovie.y = 0;
            raiseMovieArray.push(raiseMovie);
        }
    }

    public function update():void
    {
        for(var j:int = curExplodeMovieArray.length - 1; j >= 0; j --){  //透明度衰减，为0时回收上一帧已爆炸对象
            if(curExplodeMovieArray[j].alpha > 0.1){
                curExplodeMovieArray[j].alpha -=  alphaDecrease;
                curExplodeMovieArray[j].x +=  this._speed * Math.sin(curExplodeMovieArray[j].rotationAngle);
                curExplodeMovieArray[j].y -=  this._speed * Math.cos(curExplodeMovieArray[j].rotationAngle);
            }
            else{
                this.removeChild(curExplodeMovieArray[j]);
                curExplodeMovieArray[j].rotationAngle = curExplodeMovieArray[j].x = curExplodeMovieArray[j].y = 0;
                explodeMovieArray.push(curExplodeMovieArray[j]);//放入未爆炸烟花数组，等待下一次爆炸
                curExplodeMovieArray.splice(j,1);//弹出已爆炸烟花对象
            }
        }

        for(var i:int = curRaiseMovieArray.length - 1; i >= 0; i -- ){ // 上升效果
            curRaiseMovieArray[i].y = curRaiseMovieArray[i].y - this._speed;
            var fireMaxHeight:int =  Math.round(Math.random() * 10000) % 150 + 10; //假设最高值，随机数+10（爆炸半径7）
            if(curRaiseMovieArray[i].y < fireMaxHeight){ // 到达最高点
                var raiseFireTransForm:Transform = new Transform(curRaiseMovieArray[i] as MovieClip);
                var explodeColor: ColorTransform = new ColorTransform();//new一个对象
                explodeColor.color = raiseFireTransForm.colorTransform.color;//选择原有的颜色
                for(var k:int = 0; k < 36 ; k++){
                    var explodeMovie:ExplodeMovie = explodeMovieArray.pop();//弹出爆炸烟花对象
                    explodeMovie.x = curRaiseMovieArray[i].x;
                    explodeMovie.y = curRaiseMovieArray[i].y;
                    explodeMovie.rotationAngle = k * 10;
                    explodeMovie.alpha = 1;
                    var explodeFireTransForm:Transform = new Transform(explodeMovie as MovieClip);
                    explodeFireTransForm.colorTransform = explodeColor;//设置爆炸烟花颜色

                    curExplodeMovieArray.push(explodeMovie);//放入当前爆炸烟花数组，等待下一帧回收
                    this.addChild(explodeMovie);//添加入stage
                }
                this.removeChild(curRaiseMovieArray[i]); // 移除上升对象，变为爆炸对象
                curRaiseMovieArray[i].x = curRaiseMovieArray[i].y = 0;  //回收前初始化
                raiseMovieArray.push(curRaiseMovieArray[i]);//填回对象池
                curRaiseMovieArray.splice(i , 1);//删除数组中的元素
            }
        }


        if(count % interval == 0){ //达到间隔，添加上升烟花对象到舞台
            var raiseMovie:RaiseMovie = raiseMovieArray.pop();
            raiseMovie.x = Math.round(Math.random() * 10000) % 520 + 20;
            raiseMovie.y = 330;
            var myRaiseTransForm:Transform= new Transform(raiseMovie as MovieClip);
            var myRaiseColor: ColorTransform = new ColorTransform();//指定颜色的值
            myRaiseColor.color = color;
            myRaiseTransForm.colorTransform = myRaiseColor;
            curRaiseMovieArray.push(raiseMovie);
            this.addChild(raiseMovie);
        }
        count = count + 1;
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