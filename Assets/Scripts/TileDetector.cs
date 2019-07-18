using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TileDetector : MonoBehaviour
{
    int tampon = 0;
    // Update is called once per frame
    void Update()
    {
        tampon -= (tampon < 0 ) ? 0 : 1;    
    }

    void OnTriggerEnter(Collider collider)
    {
        if (collider.gameObject.tag == "tile" && tampon <= 0 )
        {
            GameManager.instance.levelManager.TileArrived(collider.gameObject);
            tampon = 3;
        }
    }
}
