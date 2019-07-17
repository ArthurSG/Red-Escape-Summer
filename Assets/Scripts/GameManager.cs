using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;
    public static LevelManager levelManager;
    public static Fabrique fabrique;
    public GameObject Avatar;
    public int a = 0;
    //public static MovementController movementController;

    public static GenerationProcedurale generationProcedurale;
	public static ControllerListener controllerListener;
    
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

        generationProcedurale = GetComponent<GenerationProcedurale>();

    }
}
