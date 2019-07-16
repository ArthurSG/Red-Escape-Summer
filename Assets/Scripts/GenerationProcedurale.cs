using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GenerationProcedurale : MonoBehaviour
{
	public GameObject tile;

    void Start()
    {
        GameManager.fabrique.TileInstantiate(tile);
    }


    void Update()
    {
        
    }
}
