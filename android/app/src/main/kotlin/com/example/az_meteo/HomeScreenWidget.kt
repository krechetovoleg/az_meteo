package com.example.az_meteo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

/**
 * Implementation of App Widget functionality.
 */
class HomeScreenWidget : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {

        for (appWidgetId in appWidgetIds) {

            //val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.home_screen_widget).apply {

                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)

                val currentTemp = widgetData.getString( "currentTemp", null)
                setTextViewText(R.id.currentTemp, currentTemp ?: "Нет данных" )

                val lastTime = widgetData.getString( "lastTime", null)
                setTextViewText(R.id.lastTime, lastTime ?: "Нет данных" )

                val pressure = widgetData.getString( "pressure", null)
                setTextViewText(R.id.pressure, pressure ?: "Нет данных" )

                val humidity = widgetData.getString( "humidity", null)
                setTextViewText(R.id.humidity, humidity ?: "Нет данных" )

                val wind = widgetData.getString( "wind", null)
                setTextViewText(R.id.wind, wind ?: "Нет данных" )

                val colorText = ("#" + (widgetData.getString( "colorText", "#FFFFFF")?.substring(2,8) ?: "#FFFFFF"))
                val colorInt = Color.parseColor(colorText ?: "#FFFFFF")
                setTextColor(R.id.currentTemp, colorInt)
                setTextColor(R.id.lastTime, colorInt)
                setTextColor(R.id.pressure, colorInt)
                setTextColor(R.id.humidity, colorInt)
                setTextColor(R.id.wind, colorInt)
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

