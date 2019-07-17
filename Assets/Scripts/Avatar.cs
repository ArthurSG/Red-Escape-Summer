using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour
{
    Rigidbody rig;
    float movementValue = 0;
    public float vitesseLaterale;

    // Start is called before the first frame update
    void Start()
    {
        rig = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        rig.velocity = new Vector3(movementValue, 0, 0);
    }

    public void SideMovement(float input)
    {
        movementValue = input * vitesseLaterale;
    }


    // Entre en contact avec un Collider
    public void Touche()
    {
        transform.GetChild(1).gameObject.SetActive(false);
    }
}
