using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    public static int LONGUEUR_TILE = 20;
    public static int LARGEUR_TILE = 100;

    // Start is called before the first frame update
    void Start()
    {
        GameManager.levelManager.AddChild(this);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void FixedUpdate()
    {
        this.transform.position = new Vector3(transform.position.x, transform.position.y, transform.position.z - 2);

        if (transform.position.z <= -20)
            Destroy(gameObject);
    }

    public void MouvementLateral(float movementValue)
    {
        transform.position = new Vector3(transform.position.x + movementValue, transform.position.y, transform.position.z);
    }

    void OnDestroy()
    {
        GameManager.levelManager.SupprChild(this);
    }
}
