package scenes
{
    import flash.geom.Point;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Canvas;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.filters.ColorMatrixFilter;
    import starling.text.TextField;

    public class MaskScene extends Scene
    {
        private var mContents:Sprite;
        private var mMask:Canvas;
        
        public function MaskScene()
        {
            mContents = new Sprite();
            addChild(mContents);
            
            var stageWidth:Number  = Starling.current.stage.stageWidth;
            var stageHeight:Number = Starling.current.stage.stageHeight;
            
            var touchQuad:Quad = new Quad(stageWidth, stageHeight);
            touchQuad.alpha = 0; // only used to get touch events
            addChildAt(touchQuad, 0);
            
            var image:Image = new Image(Game.assets.getTexture("flight_00"));
            image.x = (stageWidth - image.width) / 2;
            image.y = 80;
            mContents.addChild(image);

            // just to prove it works, use a filter on the image.
            var cm:ColorMatrixFilter = new ColorMatrixFilter();
            cm.adjustHue(-0.5);
            image.filter = cm;
            
            var maskText:TextField = new TextField(256, 128,
                "Move the mouse (or a finger) over the screen to move the mask.");
            maskText.x = (stageWidth - maskText.width) / 2;
            maskText.y = 260;
            maskText.fontSize = 20;
            mContents.addChild(maskText);
            
            mMask = new Canvas();
            mMask.beginFill(0xff0000);
            mMask.drawCircle(0, 0, 100);
            mMask.endFill();
            mMask.alpha = 0.1;
            mMask.touchable = false;
            addChild(mMask);

            mContents.mask = mMask;
            
            addEventListener(TouchEvent.TOUCH, onTouch);
        }
        
        private function onTouch(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(this, TouchPhase.HOVER) ||
                              event.getTouch(this, TouchPhase.BEGAN) ||
                              event.getTouch(this, TouchPhase.MOVED);

            if (touch)
            {
                var localPos:Point = touch.getLocation(this);
                mMask.x = localPos.x;
                mMask.y = localPos.y;
            }
        }
    }
}