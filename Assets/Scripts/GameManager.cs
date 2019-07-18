using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;
    public LevelManager levelManager;
    public TilePool tilePool;
    public GameObject avatar;
    public float vitesse = 1f;

    public Text scoreText, scoreTextShadow;

    private bool isGameRunning = false;
    private bool isPlayerDead = false;
    private float score = 0;

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

    void Update() {
        if (isGameRunning){
            UpdateScore();
        }
    }
    
    public void PlayerDied()
    {
        isGameRunning = false;
        isPlayerDead = true;
        MenuManager.instance.DisplayEndGame();
    }

    public void GameRestarted() {
        score = 0;
        isGameRunning = true;
        avatar.GetComponent<Avatar>().GameStarted();
    }

    public void GameStarted()
    {
        isGameRunning = true;
        // avatar.GetComponent<Avatar>().GameStarted();
    }

    public bool IsGameRunning()
    {
        return isGameRunning;
    }

    public void UpdateScore() {
        score += Time.deltaTime;
        scoreText.text = score.ToString("0");
        scoreTextShadow.text = score.ToString("0");
    }
}
