using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControllerListener : MonoBehaviour
{
   	float movementValue;
   	MovementController movementController;

    void Start()
    {
        movementController = GetComponent<MovementController>();
    }


    void Update()
    {
    	movementValue = - Input.GetAxis("Horizontal");
    	print (movementValue);

    	movementController.Movement(movementValue);
        
    }

}
