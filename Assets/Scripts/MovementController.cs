using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovementController : MonoBehaviour
{
	List<Tile> tiles;
	LevelManager levelManager;
    Avatar ship;

    bool GameManagerUp;


    void Start()
    {
    	   
    }
    void FixedUpdate ()
    {
    

        if (GameManager.instance != null)
        {
            GameManagerUp = true;
        }
        if (GameManagerUp)
        {
            ResetAvatar();
        }
    }


    void Update()
    {

    }

    void ResetAvatar(){
        ship = GameManager.instance.avatar.GetComponent<Avatar>();
    }

    public void Movement (float movementValue)
    {
        ship.SideMovement(movementValue);
    }
}
