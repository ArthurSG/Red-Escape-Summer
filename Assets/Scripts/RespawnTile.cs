using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RespawnTile : MonoBehaviour
{

    //public static float lateralMovementAmount; // Stock la distance qu'à parcouru la tile dans sa vie. 
    float positionx; // Old Position

    // Start is called before the first frame update
    void Start()
    {
        positionx = this.transform.position.x;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void FixedUpdate()
    {
        if (transform.position.z <= -20) {
            GameManager.generationProcedurale.NewTile();
            Destroy(this.gameObject);
        }
    }
}
