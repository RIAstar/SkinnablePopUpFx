/*
 * Copyright (c) 2013 Maxime Cowez a.k.a. RIAstar.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * @author RIAstar
 */
package net.riastar.demo.view {

import mx.events.PropertyChangeEvent;

import net.riastar.demo.skin.CustomAlertSkin;

import spark.components.TextArea;


public class ToasterCodeArea extends TextArea {

    private var _properties:ToasterPropertyPanel;
    public function get properties():ToasterPropertyPanel { return _properties; }
    public function set properties(value:ToasterPropertyPanel):void {
        if (_properties) _properties.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, handlePropertyChange);
        _properties = value;
        invalidateProperties();
        if (value) value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, handlePropertyChange);
    }

    private function handlePropertyChange(event:PropertyChangeEvent):void {
        invalidateProperties();
    }

    override protected function commitProperties():void {
        super.commitProperties();
        if (!_properties) return;

        var props:Array = ['<rs:Toaster width="150"'];

        //properties
        if (_properties.showTime != 5000)
            props.push('showTime="' + properties.showTime + '"');
        if (_properties.itemRenderer != _properties.defaultItemRenderer)
            props.push('itemRenderer="net.riastar.demo.skin.CustomToastItemRenderer"');

        for each (var prop:String in ['top', 'verticalCenter', 'bottom', 'left', 'horizontalCenter', 'right'])
            if (!isNaN(_properties['_' + prop]))
                props.push(prop + '="' + _properties['_' + prop] + '"');

        text = props.join("\n            ") + ' />';
    }

}
}
