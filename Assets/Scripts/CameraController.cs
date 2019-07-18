using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public float minFov = 60;
    public float maxFov = 90;
    Camera cam;
    void Start() {
        cam = GetComponent<Camera>();
    }

    void Update() {
        float interpolation = (GameManager.instance.GetSpeed() - GameManager.instance.minSpeed) / GameManager.instance.maxSpeed;
        cam.fieldOfView = Mathf.Lerp(minFov, maxFov, interpolation);
        print(interpolation);
    }
}
