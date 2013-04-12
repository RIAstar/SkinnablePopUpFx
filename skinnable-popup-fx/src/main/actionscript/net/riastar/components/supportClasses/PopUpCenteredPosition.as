package net.riastar.components.supportClasses {

import mx.managers.PopUpManager;

import net.riastar.components.SkinnablePopUp;


public class PopUpCenteredPosition implements IPopUpPosition {

    public function update(popUp:SkinnablePopUp):void {
        if (popUp) PopUpManager.centerPopUp(popUp);
    }

}
}
