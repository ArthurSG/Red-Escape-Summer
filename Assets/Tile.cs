using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GameManager.levelManager.AddChild(this);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnDestroy()
    {
    	GameManager.levelManager.SupprChild(this);
    }
}
