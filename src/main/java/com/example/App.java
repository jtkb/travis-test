package com.example;

import com.javatechnics.flexfx.scene.SceneService;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.layout.CornerRadii;
import javafx.scene.paint.Color;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

import java.io.IOException;

public class App implements SceneService, BundleActivator
{
    private final Scene scene;
    private ServiceRegistration<SceneService> serviceServiceRegistration;

    public App()
    {
        AnchorPane parent = new AnchorPane();
        scene = new Scene(parent);
        parent.setMinHeight(200);
        parent.setMaxHeight(200);
        parent.setPrefHeight(200);
        parent.setMinWidth(200);
        parent.setMaxHeight(200);
        parent.setPrefHeight(200);
        parent.setBackground(new Background(new BackgroundFill(Color.RED, CornerRadii.EMPTY, Insets.EMPTY)));
    }

    @Override
    public Scene getScene() throws IOException
    {
        return scene;
    }

    @Override
    public void start(final BundleContext bundleContext) throws Exception
    {
        serviceServiceRegistration = bundleContext.registerService(SceneService.class, this, null);
    }

    @Override
    public void stop(final BundleContext bundleContext) throws Exception
    {
        serviceServiceRegistration.unregister();
    }
}
