using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightTrailEffect : MonoBehaviour
{
    
	LineRenderer lineRenderer;
	Vector3 emitterPosition;
	//Vector3 endOfTheLinePosition;
	public GameObject emitter;

	Timer timeBetweenPoints;
	int lengthOfTheLine;
	bool firstTime;
	int pointIndex = 0;


	Vector3[] points;
	Vector3[] movingPoints;

	float t;

    void Start()
    {
    	Initialisation();
    	timeBetweenPoints = new Timer (1f, SendPoints);

    	timeBetweenPoints.Play();

    }


    void Update()
    {

        
    }


    void FixedUpdate ()
    {
    	t = Time.deltaTime;
    	if (!firstTime)
    		InitialisationLine();
    	PointsMovement();

    }

    void PointsMovement ()
    {
    	
    	//Movement 1
    	
 		// INITIALISATION

        //MOVING THE POINTS
        for (int i = 0; i < lineRenderer.positionCount; i++)
        {
        	points[i] += movingPoints[i];
       		//points[i] += new Vector3 (0, 0, t/1000);
       		
       		if (points[i].z - emitterPosition.z > 6)
       		{
       			points[i] = emitterPosition;
       			//lineRenderer.SetPosition(i, points[i]);

       		}
		} 

		lineRenderer.SetPositions(points);   

        // Connect the start and end positions of the line together to form a continuous loop.
        lineRenderer.loop = true;
    }

    void SendPoints()
    {
    	pointIndex ++;

    	if (pointIndex >= lengthOfTheLine)
    		pointIndex = 0;
    	movingPoints[pointIndex] = new Vector3 (0, 0, t);


    	//lineRenderer.SetPosition(pointIndex, points[pointIndex]);
    	timeBetweenPoints.ResetPlay();
    }




    void InitialisationLine()
    {
    	//var points = new Vector3[lengthOfTheLine];
        for (int i = 0; i < lengthOfTheLine; i++)
        {
        	
        	//points[i] = new Vector3 (emitterPosition.x,emitterPosition.y,emitterPosition.z);
        	points[i] = emitterPosition;
        	lineRenderer.SetPosition(i, points[i]);

        }
        //lineRenderer.SetPositions(points);
        firstTime = true;

    }




    void Initialisation()
    {
    	emitterPosition = emitter.transform.position;
    	//endOfTheLinePosition = new Vector3 (emitterPosition.x, emitterPosition.y, endOfTheLinePosition.z -3);
        lineRenderer = GetComponent<LineRenderer>();
        lengthOfTheLine = lineRenderer.positionCount;

        points = new Vector3[lengthOfTheLine];
        movingPoints = new Vector3[lengthOfTheLine];

    }
}
