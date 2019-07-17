using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    public static int LONGUEUR_TILE = 20;
    public static int LARGEUR_TILE = 100;

    void Start()
    {
        //Add itself to the levelManager Tiles list
        GameManager.levelManager.AddChild(this);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void FixedUpdate()
    {
        //Move backwards
        this.transform.position = new Vector3(transform.position.x, transform.position.y, transform.position.z - 2);

        //If i'm too far behind, destroy
        if (transform.position.z <= -25)
            Destroy(gameObject);
    }

    public void MouvementLateral(float movementValue)
    {
        // transform.position = new Vector3(transform.position.x + movementValue, transform.position.y, transform.position.z);
    }

    //Use to suppr itself from the level manager list
    void OnDestroy()
    {
        GameManager.levelManager.SupprChild(this);
    }
}
