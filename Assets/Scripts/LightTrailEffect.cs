using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightTrailEffect : MonoBehaviour
{
    
	LineRenderer lineRenderer;
	Vector3 oldPosition;
	Vector3 endOfTheLine;

    void Start()
    {
    	oldPosition = this.transform.position;
        lineRenderer = GetComponent<LineRenderer>();
    }


    void Update()
    {
        
    }
}
