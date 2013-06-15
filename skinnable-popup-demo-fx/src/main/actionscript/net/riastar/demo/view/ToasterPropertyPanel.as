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

import mx.core.ClassFactory;

import net.riastar.skins.spark.ToastRenderer;

import spark.components.supportClasses.SkinnableComponent;


public class ToasterPropertyPanel extends SkinnableComponent {

    [Bindable]
    public var showTime:int = 5000;

    [Bindable]
    public var defaultItemRenderer:* = new ClassFactory(ToastRenderer);

    [Bindable]
    public var itemRenderer:* = defaultItemRenderer;

    private var __top:Number = NaN;
    [Bindable]
    public function get _top():Number { return __top; }
    public function set _top(value:Number):void {
        __top = value;
        if (!isNaN(value)) {
            _verticalCenter = NaN;
            _bottom = NaN;
        }
    }

    private var __verticalCenter:Number = NaN;
    [Bindable]
    public function get _verticalCenter():Number { return __verticalCenter; }
    public function set _verticalCenter(value:Number):void {
        __verticalCenter = value;
        if (!isNaN(value)) {
            _top = NaN;
            _bottom = NaN;
        }
    }

    private var __bottom:Number = 30;
    [Bindable]
    public function get _bottom():Number { return __bottom; }
    public function set _bottom(value:Number):void {
        __bottom = value;
        if (!isNaN(value)) {
            _top = NaN;
            _verticalCenter = NaN;
        }
    }

    private var __left:Number = NaN;
    [Bindable]
    public function get _left():Number { return __left; }
    public function set _left(value:Number):void {
        __left = value;
        if (!isNaN(value)) {
            _horizontalCenter = NaN;
            _right = NaN;
        }
    }

    private var __horizontalCenter:Number = 0;
    [Bindable]
    public function get _horizontalCenter():Number { return __horizontalCenter; }
    public function set _horizontalCenter(value:Number):void {
        __horizontalCenter = value;
        if (!isNaN(value)) {
            _left = NaN;
            _right = NaN;
        }
    }

    private var __right:Number = NaN;
    [Bindable]
    public function get _right():Number { return __right; }
    public function set _right(value:Number):void {
        __right = value;
        if (!isNaN(value)) {
            _left = NaN;
            _horizontalCenter = NaN;
        }
    }

}
}
