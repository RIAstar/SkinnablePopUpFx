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


public class AlertCodeArea extends TextArea {

    private var _properties:AlertPropertyPanel;
    public function get properties():AlertPropertyPanel {
        return _properties;
    }
    public function set properties(value:AlertPropertyPanel):void {
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
        if (!properties) return;

        var props:Array = ['<rs:Alert maxWidth="' + properties.maxPopUpWidth + '"'];

        //properties
        if (!properties.modal)
            props.push('modal="false"');
        if (properties.title && properties.title.length)
            props.push('title="' + properties.title + '"');
        if (properties.text && properties.text.length)
            props.push('text="' + properties.text + '"');
        if (!properties.committable)
            props.push('committable="false"');
        if (properties.discardable)
            props.push('discardable="true"');
        if (properties.cancelable)
            props.push('cancelable="true"');
        if (properties.commitLabel && properties.commitLabel.length)
            props.push('commitLabel="' + properties.commitLabel + '"');
        if (properties.discardLabel && properties.discardLabel.length)
            props.push('discardLabel="' + properties.discardLabel + '"');
        if (properties.cancelLabel && properties.cancelLabel.length)
            props.push('cancelLabel="' + properties.cancelLabel + '"');

        //styles
        if (properties._skinClass == CustomAlertSkin)
            props.push('skinClass="net.riastar.demo.skin.CustomAlertSkin"');
        else {
            if (properties.backgroundAlpha != 1)
                props.push('backgroundAlpha="' + properties.backgroundAlpha + '"');
            if (properties.backgroundColor != 0xffffff)
                props.push('backgroundColor="0x' + properties.backgroundColor.toString(16) + '"');
            if (properties.borderAlpha != .5)
                props.push('borderAlpha="' + properties.borderAlpha + '"');
            if (properties.borderColor != 0x000000)
                props.push('borderColor="0x' + properties.borderColor.toString(16) + '"');
            if (properties.borderVisible == false)
                props.push('borderVisible="false"');
            if (properties.cornerRadius != 0)
                props.push('cornerRadius="' + properties.cornerRadius + '"');
            if (properties.color != 0x000000)
                props.push('color="0x' + properties.color.toString(16) + '"');
            if (properties.dropShadowVisible == false)
                props.push('dropShadowVisible="false"');
        }

        text = props.join("\n          ") + ' />';
    }

}

}
