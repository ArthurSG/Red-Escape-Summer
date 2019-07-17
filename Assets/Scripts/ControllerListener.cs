using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControllerListener : MonoBehaviour
{

    float movementValue;
    MovementController movementController;

    bool pressedL = false;
    bool pressedR = false;



    void Start()
    {
        movementController = GetComponent<MovementController>();
    }


    void Update()
    {  
        print(pressedR);
        print(pressedL);

        /*if (Input.GetAxis("Horizontal") != 0)
           movementValue = Input.GetAxis("Horizontal");
        */

        movementValue = 0;

        if (pressedL)
            movementValue --;
        if (pressedR)
            movementValue ++;



        movementController.Movement(movementValue);
        
    }

    public void ClickLeft ()
    {
        pressedL = true;
    }

    public void ReleaseLeft()
    {
        pressedL = false;
    }

    public void ClickRight ()
    {
        pressedR = true;
    }

    public void ReleaseRight()
    {
        pressedR = false;
    }
}