using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;
    public LevelManager levelManager;
    public TilePool tilePool;
    public GameObject avatar;
    public float vitesse = 1f;

    private bool isGameRunning = false;

	public static ControllerListener controllerListener;
    
    void Start() 
    {
    	if (instance != null) 
    	{
    		print("Multiples instances de game manager");
    	}
    	instance = this;

    	levelManager = GetComponent<LevelManager>();
    	tilePool = GetComponent<TilePool>();
    }
    
    public void PlayerDied()
    {
        isGameRunning = false;
    }

    public void GameStarted()
    {
        isGameRunning = true;
        avatar.GetComponent<Avatar>().GameStarted();
    }

    public bool IsGameRunning()
    {
        return isGameRunning;
    }
}
