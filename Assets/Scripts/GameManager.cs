using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;
    public static LevelManager levelManager;
    public static Fabrique fabrique;
    //public static MovementController movementController;
    
    void Start() 
    {
    	if (instance != null) 
    	{
    		print("Multiples instances de game manager");
    	}
    	instance = this;

    	levelManager = GetComponent<LevelManager>();
    	fabrique = GetComponent<Fabrique>();
    	//movementController = GetComponent<MovementController>();

    }

}
