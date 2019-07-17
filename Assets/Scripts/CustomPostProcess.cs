using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CustomPostProcess : MonoBehaviour
{
    public Material material;
    public Transform tr;
    public float radius = 0.25f;

    // Postprocess the image
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }

    private void PassRadius(Transform tr, string materialAddress)
    {
        float radius = (tr.localScale.x * 80.0f) / 110.0f; //it's a kind of magic
        material.SetFloat(materialAddress, radius);
    }

    private void PassPosition(Transform tr, string materialAddress)
    {
        material.SetVector(materialAddress, tr.position);
    }

}
