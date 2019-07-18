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
        cam.fieldOfView = Mathf.Lerp(minFov, maxFov, GetInterpolation());
    }

    float GetInterpolation() {
        float speed = GameManager.instance.GetSpeed();
        float maxSpeed = GameManager.instance.maxSpeed;
        float minSpeed = GameManager.instance.minSpeed;
        return (speed - minSpeed) / (maxSpeed - minSpeed);

    }
}
