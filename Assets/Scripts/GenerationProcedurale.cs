using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GenerationProcedurale : MonoBehaviour
{
	public List<GameObject> tiles;
    private int nextIndex = -1;

    void Start()
    {
        NewTile();
    }


    void Update()
    {
        
    }

    public void NewTile()
    {
        int index = getIndex();
        GameManager.fabrique.TileInstantiate(tiles[index]);
    }

    int getIndex()
    {
        // Menu
        /*
        if (isMenu)
            return 0;
        */

        // Si la tile précédente demande une tile en particulier
        if (nextIndex != -1)
            return nextIndex;

        // Sinon 
        return Random.Range(0, tiles.Count);

    }
}
