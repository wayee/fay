package mm.fay.event
{
	import flash.events.Event;

	/**
	 * Base Event
	 *  
	 * @author Andy Cai <huayicai@gmail.com>
	 * 
	 */
    public class FEvent extends Event
	{
        public static const COMPLETE:String = "FEvent.complete";

        private var _data:Object;
        private var _type:String;

        public function FEvent(type:String, eventType:String, data:Object)
		{
            super(type);
            this._data = data;
            this._type = eventType;
        }
		
        public function get eventData():Object
		{
            return this._data;
        }
		
        public function get eventType():String
		{
            return this._type;
        }
    }
}