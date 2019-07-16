using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControllerListenerKeyboard : MonoBehaviour
{
	public float movementValue;

    void Start()
    {
        
    }


    void Update()
    {
    	movementValue = Input.GetAxis("Horizontal");
        
    }
}
