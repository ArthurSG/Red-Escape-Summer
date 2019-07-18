using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour
{
    Rigidbody rig;
    Animator animator;
    
    public float movementInput = 0, lateralSpeed;
    public float lateralSpeedSensitivity = .5f, maxLateralSpeed = 5;
    bool isDead = false;
 
    void Start()
    {
        FetchComponents();
    }

    void Update()
    {
        if (!isDead)
            Move();
    }

    public void SideMovement(float input)
    {
        movementInput = input;
    }

    void Move() {
        Mathf.SmoothDamp(lateralSpeed, maxLateralSpeed * movementInput, ref lateralSpeed, lateralSpeedSensitivity, maxLateralSpeed);
        // lateralSpeed += (Time.deltaTime * lateralSpeedSensitivity) * movementInput;
        // NormalizeLateralSpeed();
        animator.SetFloat("SpeedX", lateralSpeed / maxLateralSpeed);
        rig.velocity = new Vector3(lateralSpeed, 0, 0);
    }
    
    // Entre en contact avec un Collider
    public void Touche()
    {
        Died();
    }

    public void GameStarted()
    {
        transform.GetChild(1).gameObject.SetActive(true);
        animator.SetBool("Dead", false);
    }

    void FetchComponents() {
        rig = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }

    void Died() {
        GameManager.instance.PlayerDied();
        transform.GetChild(1).gameObject.SetActive(false);
        animator.SetBool("Dead", true);
    }

    void NormalizeLateralSpeed() {
        lateralSpeed = Mathf.Max(lateralSpeed, -maxLateralSpeed);
        lateralSpeed = Mathf.Min(lateralSpeed, maxLateralSpeed);
    }

    public bool IsAccelerating() {
        return movementInput == 0;
    }
}
