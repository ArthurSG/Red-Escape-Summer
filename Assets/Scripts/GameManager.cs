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
    public float maxSpeed = 2.4f, minSpeed = 2f;
    public float accelerationTime = 1f;
    public float deccelerationTime = 1;
    //[HideInInspector]
    public float speed = 1f;
    Avatar avatarScript;
    public Text scoreText, scoreTextShadow;

    private bool isGameRunning = false;
    private bool isPlayerDead = false;
    private float score = 0;

	public static ControllerListener controllerListener;
    
    void Start() 
    {
        CreateSingletonInstance();
        FetchComponents();
        
    }

    void Update() {
        if (isGameRunning){
            UpdateScore();
            UpdateSpeed();
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

    public void UpdateSpeed() {
        if (avatarScript == null) return;

        if(avatarScript.IsAccelerating())
            speed = Mathf.MoveTowards(speed, maxSpeed, accelerationTime * Time.deltaTime);
        else
            speed = Mathf.MoveTowards(speed, minSpeed, deccelerationTime * Time.deltaTime);
        //Debug.Log(speed);
    }

    void FetchComponents() {
    	levelManager = GetComponent<LevelManager>();
    	tilePool = GetComponent<TilePool>();
        avatarScript = avatar.GetComponent<Avatar>();
    }

    public float GetSpeed() {
        return speed * 2;
    }
    void CreateSingletonInstance() {
    	if (instance != null) 
    	{
    		print("Multiples instances de game manager");
    	}
    	instance = this;
    }

    public float GetScore()
    {
        return score;
    }
}
