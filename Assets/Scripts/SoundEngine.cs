using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundEngine : MonoBehaviour
{
    public FMODUnity.StudioEventEmitter emitter;

    public float paramMin = 0;
    public float paramMax = 1;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

        float value = Remap(GameManager.instance.minSpeed, GameManager.instance.maxSpeed, paramMin, paramMax, GameManager.instance.speed);
        emitter.EventInstance.setParameterValue("Speed", value);
    }


    float Remap(float a1, float a2, float b1, float b2, float value)
    {
        return b1 + (value - a1) * (b2 - b1) / (a2 - a1);
    }
}
