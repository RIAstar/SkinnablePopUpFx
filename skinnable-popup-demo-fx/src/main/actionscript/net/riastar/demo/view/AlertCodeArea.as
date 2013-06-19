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
        if (!_properties) return;

        var props:Array = ['<rs:Alert maxWidth="' + _properties.maxPopUpWidth + '"'];

        //properties
        if (!_properties.modal)
            props.push('modal="false"');
        if (_properties.title && _properties.title.length)
            props.push('title="' + _properties.title + '"');
        if (_properties.text && _properties.text.length)
            props.push('text="' + _properties.text + '"');
        if (!_properties.committable)
            props.push('committable="false"');
        if (_properties.discardable)
            props.push('discardable="true"');
        if (_properties.cancelable)
            props.push('cancelable="true"');
        if (_properties.commitLabel && _properties.commitLabel.length)
            props.push('commitLabel="' + _properties.commitLabel + '"');
        if (_properties.discardLabel && _properties.discardLabel.length)
            props.push('discardLabel="' + _properties.discardLabel + '"');
        if (_properties.cancelLabel && _properties.cancelLabel.length)
            props.push('cancelLabel="' + _properties.cancelLabel + '"');

        //styles
        if (_properties._skinClass == CustomAlertSkin)
            props.push('skinClass="net.riastar.demo.skin.CustomAlertSkin"');
        else {
            if (_properties.icon)
                props.push('icon="@Embed(\'gfx/warning.png\')"');
            if (_properties.iconPlacement != "left")
                props.push('iconPlacement="' + _properties.iconPlacement + '"');
            if (_properties.iconAlign != "middle")
                props.push('iconAlign="' + _properties.iconAlign + '"');
            if (_properties.backgroundAlpha != 1)
                props.push('backgroundAlpha="' + _properties.backgroundAlpha + '"');
            if (_properties.backgroundColor != 0xffffff)
                props.push('backgroundColor="0x' + _properties.backgroundColor.toString(16) + '"');
            if (_properties.borderAlpha != .5)
                props.push('borderAlpha="' + _properties.borderAlpha + '"');
            if (_properties.borderColor != 0x000000)
                props.push('borderColor="0x' + _properties.borderColor.toString(16) + '"');
            if (_properties.borderVisible == false)
                props.push('borderVisible="false"');
            if (_properties.cornerRadius != 0)
                props.push('cornerRadius="' + _properties.cornerRadius + '"');
            if (_properties.color != 0x000000)
                props.push('color="0x' + _properties.color.toString(16) + '"');
            if (_properties.dropShadowVisible == false)
                props.push('dropShadowVisible="false"');
        }

        text = props.join("\n          ") + ' />';
    }

}

}
