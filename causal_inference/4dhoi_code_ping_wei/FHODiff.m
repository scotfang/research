function  HODiff = FHODiff(MhtSkel,ObjBc,ObjInd)

switch(ObjInd)
    case 1  %%% 01_mug
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        HODiff = ObjBc - repmat((MhtSkel(11,:) + rv),size(ObjBc,1),1);
   case 2  %%% 02_phone
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        HODiff = ObjBc - repmat((MhtSkel(11,:) + rv),size(ObjBc,1),1);       
    case 3  %%% 03_book
        rv = MhtSkel(7,:) - MhtSkel(6,:);
        HODiff = ObjBc - repmat((MhtSkel(7,:) + rv),size(ObjBc,1),1);
    case 4  %%% 04_mouse
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        HODiff = ObjBc - repmat((MhtSkel(11,:) + rv),size(ObjBc,1),1);        
    case 5  %%% 05_keyboard
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        HODiff = ObjBc - repmat((MhtSkel(11,:) + rv),size(ObjBc,1),1);        
    case 6  %%% 06_dispenser
        rv = MhtSkel(7,:) - MhtSkel(6,:);
        HODiff = ObjBc - repmat((MhtSkel(7,:) + rv),size(ObjBc,1),1);     
    case 7  %%% 07_kettle
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        HODiff = ObjBc - repmat((MhtSkel(11,:) + rv),size(ObjBc,1),1);     
    case 8  %%% 08_button
        rv1 = MhtSkel(11,:) - MhtSkel(10,:);
        rv2 = MhtSkel(9,:) - MhtSkel(5,:);
        box_center1 = MhtSkel(11,:) + rv1;        %%% box center in Mahattan space
        box_center2 = MhtSkel(9,:) + 3*rv2;
        box_center = (box_center1+box_center2)/2;        
        HODiff = ObjBc - repmat(box_center,size(ObjBc,1),1);        
    case 9  %%% 09_monitor
        rv = MhtSkel(9,:) - MhtSkel(5,:);
        box_center = MhtSkel(10,:) + 1.2*rv;
        HODiff = ObjBc - repmat(box_center,size(ObjBc,1),1); 
    case 10 %%% 10_chair
        box_center = MhtSkel(2,:);    %%% box center in Mahattan space
        HODiff = ObjBc - repmat(box_center,size(ObjBc,1),1); 
    case 11 %%% 11_desk
        rv = MhtSkel(11,:) - MhtSkel(10,:);
        box_center = MhtSkel(11,:) + rv;
        HODiff = ObjBc - repmat(box_center,size(ObjBc,1),1); 
end